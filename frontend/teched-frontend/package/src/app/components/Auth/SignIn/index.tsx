'use client'

import Link from 'next/link'
import SocialSignIn from '../SocialSignIn'
import Logo from '@/app/components/Layout/Header/Logo'
import { useState, useEffect } from 'react'
import { useRouter } from 'next/navigation' // Per il reindirizzamento ai corsi

const Signin = () => {
  const router = useRouter();
  const [formData, setFormData] = useState({ email: "" });
  const [showModal, setShowModal] = useState(false);
  const [otp, setOtp] = useState(['', '', '', '', '', '']); // 6 cifre
  const [timer, setTimer] = useState(60);

  // Gestore countdown
  useEffect(() => {
    let interval: NodeJS.Timeout;
    if (showModal && timer > 0) {
      interval = setInterval(() => {
        setTimer((prev) => prev - 1);
      }, 1000);
    }
    return () => clearInterval(interval);
  }, [showModal, timer]);

  const handleChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const { name, value } = e.target;
    setFormData({ ...formData, [name]: value });
  };

  const handleOtpChange = (element: HTMLInputElement, index: number) => {
    if (isNaN(Number(element.value))) return false;
    const newOtp = [...otp];
    newOtp[index] = element.value;
    setOtp(newOtp);

    // Focus automatico sul prossimo input
    if (element.nextSibling && element.value !== "") {
      (element.nextSibling as HTMLInputElement).focus();
    }
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    try { 
      const response = await fetch("/api/v1/auth/otp/request", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ email: formData.email }),
      });

      if (response.ok) {
        setShowModal(true);
        setTimer(60); // Reset timer
      } else {
        alert("Errore nella richiesta al server.");
      }
    } catch (error) {
      console.error("Errore di rete:", error);
    }
  };

 const verifyOtp = async () => {
    const fullOtp = otp.join('');
    
    // NOTA: Chiama /api/login (la rotta BFF), non il backend 8080 direttamente
    const response = await fetch('/api/login', { 
      method: 'POST',
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ email: formData.email, otp: fullOtp })
    });

    if (response.ok) {
      // NON salva nulla in LocalStorage. Il cookie è già nel browser
      router.push('/corsi'); 
    } else {
      alert('OTP non valido!');
    }
};
  return (
    <>
      {/* Form Originale */}
      <div className='mb-10 text-center mx-auto inline-block'>
        <Logo />
      </div>
      <SocialSignIn />
      <span className='z-1 relative my-8 block text-center before:absolute before:h-px before:w-[40%] before:bg-black/20 before:left-0 before:top-3 after:absolute after:h-px after:w-[40%] after:bg-black/20 after:top-3 after:right-0'>
        <span className='text-body-secondary relative z-10 inline-block px-3 text-base text-black'>OR</span>
      </span>

      <form onSubmit={handleSubmit}>
        <div className='mb-[22px]'>
          <input
            type='email'
            name='email'
            placeholder='Email'
            required
            value={formData.email}
            onChange={handleChange}
            className='w-full rounded-md border border-solid bg-transparent px-5 py-3 text-base text-black outline-hidden transition border-gray-200 focus:border-primary'
          />
        </div>
        <button type='submit' className='bg-primary w-full py-3 rounded-lg text-white font-medium border border-primary hover:bg-transparent hover:text-primary transition duration-300'>
          Request OTP
        </button>
      </form>

      {showModal && (
        <div className="fixed inset-0 z-50 flex items-center justify-center bg-black/50 backdrop-blur-sm">
          <div className="bg-white p-8 rounded-2xl shadow-xl max-w-md w-full text-center">
            <h2 className="text-2xl font-bold mb-4 text-black">Inserisci OTP</h2>
            <p className="text-gray-500 mb-6">Inviato a: {formData.email}</p>
            
            <div className="flex justify-center gap-2 mb-6">
              {otp.map((data, index) => (
                <input
                  key={index}
                  type="text"
                  maxLength={1}
                  className="w-12 h-12 border-2 rounded-lg text-center text-xl font-bold text-black focus:border-primary outline-none"
                  value={data}
                  onChange={(e) => handleOtpChange(e.target, index)}
                  onFocus={(e) => e.target.select()}
                />
              ))}
            </div>

            <div className="mb-6">
              <span className={`text-sm font-semibold ${timer === 0 ? 'text-red-500' : 'text-gray-400'}`}>
                {timer > 0 ? `Scade tra: ${timer}s` : "Codice scaduto!"}
              </span>
            </div>

            <button 
              onClick={verifyOtp}
              className="w-full bg-primary text-white py-3 rounded-lg font-bold hover:opacity-90 transition"
            >
              Verifica e vai ai Corsi
            </button>

            <button 
              onClick={() => setShowModal(false)}
              className="mt-4 text-sm text-gray-400 hover:text-black"
            >
              Annulla
            </button>
          </div>
        </div>
      )}
    </>
  )
}

export default Signin