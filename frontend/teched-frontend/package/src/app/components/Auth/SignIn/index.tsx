'use client'

import Link from 'next/link'
import SocialSignIn from '../SocialSignIn'
import Logo from '@/app/components/Layout/Header/Logo'
import { useState } from 'react'

const Signin = () => {
  // 1. Stato per i campi del form (rimosso 'name' se non necessario per il Sign In)
  const [formData, setFormData] = useState({
    email: "",
    password: "",
  });

  // 2. Gestore del cambiamento degli input
  // Grazie all'attributo 'name' sull'input, questa funzione aggiorna il campo corretto
  const handleChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const { name, value } = e.target;
    setFormData((prev) => ({
      ...prev,
      [name]: value,
    }));
  };

  // 3. Funzione per inviare i dati a Spring Boot
  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();

    try {
      // Usiamo il proxy /api configurato nel next.config.mjs
      const response = await fetch("/api/auth/otp/request", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        // Invia solo l'email al controller Java come richiesto dal modello OpenAPI
        body: JSON.stringify({ email: formData.email }),
      });

      if (response.ok) {
        alert("Codice OTP inviato correttamente!");
      } else {
        alert("Errore nella richiesta al server.");
      }
    } catch (error) {
      console.error("Errore di rete:", error);
      alert("Il server non risponde.");
    }
  };

  return (
    <>
      <div className='mb-10 text-center mx-auto inline-block'>
        <Logo />
      </div>

      <SocialSignIn />

      <span className='z-1 relative my-8 block text-center before:absolute before:h-px before:w-[40%] before:bg-black/20 before:left-0 before:top-3 after:absolute after:h-px after:w-[40%] after:bg-black/20 after:top-3 after:right-0'>
        <span className='text-body-secondary relative z-10 inline-block px-3 text-base text-black'>
          OR
        </span>
      </span>

      <form onSubmit={handleSubmit}>
        <div className='mb-[22px]'>
          <input
            type='email'
            name='email' // FONDAMENTALE: deve corrispondere alla chiave nello stato
            placeholder='Email'
            required
            value={formData.email}
            onChange={handleChange} // FONDAMENTALE: permette di scrivere nell'input
            className='w-full rounded-md border border-solid bg-transparent px-5 py-3 text-base text-dark outline-hidden transition border-gray-200 placeholder:text-black/30 focus:border-primary focus-visible:shadow-none text-black'
          />
        </div>
        <div className='mb-[22px]'>
          <input
            type='password'
            name='password' // FONDAMENTALE: deve corrispondere alla chiave nello stato
            placeholder='Password'
            required
            value={formData.password}
            onChange={handleChange} // FONDAMENTALE: permette di scrivere nell'input
            className='w-full rounded-md border border-solid bg-transparent px-5 py-3 text-base text-dark outline-hidden transition border-gray-200 placeholder:text-black/30 focus:border-primary focus-visible:shadow-none text-black'
          />
        </div>
        <div className='mb-9'>
          <button
            type='submit'
            className='bg-primary w-full py-3 rounded-lg text-18 font-medium border text-white border-primary hover:text-primary hover:bg-transparent hover:cursor-pointer transition duration-300 ease-in-out'>
            Request OTP
          </button>
        </div>
      </form>

      <Link
        href='/'
        className='mb-2 inline-block text-base text-black hover:text-primary hover:underline'>
        Forgot Password?
      </Link>
      <p className='text-black text-base'>
        Not a member yet?{' '}
        <Link href='/' className='text-primary hover:underline'>
          Sign Up
        </Link>
      </p>
    </>
  )
}

export default Signin