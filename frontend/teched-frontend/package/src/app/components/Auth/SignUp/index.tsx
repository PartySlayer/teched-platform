"use client";

import { useState } from "react"; // Aggiunto per gestire i dati
import Link from "next/link";
import SocialSignUp from "../SocialSignUp";
import Logo from "@/app/components/Layout/Header/Logo";

const SignUp = () => {
  // 1. Stato per i campi del form
  const [formData, setFormData] = useState({
    name: "",
    email: "",
    password: "",
  });

  // 2. Gestore del cambiamento degli input
  const handleChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    setFormData({ ...formData, [e.target.name]: e.target.value });
  };

  // 3. Funzione per inviare i dati a Spring Boot
const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();

    try {
      // Usiamo /api/ che Next.js ora sa come gestire
      const response = await fetch("/api/auth/otp/request", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        // Invia solo l'email come richiesto dal Controller Java
        body: JSON.stringify({ email: formData.email }),
      });

      if (response.ok) {
        alert("Codice inviato correttamente!");
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

      <SocialSignUp />

      <span className="z-1 relative my-8 block text-center before:content-[''] before:absolute before:h-px before:w-[40%] before:bg-black/20 before:bg-opacity-60 before:left-0 before:top-3 after:content-[''] after:absolute after:h-px after:w-[40%] after:bg-black/20 after:bg-opacity-60 after:top-3 after:right-0">
        <span className='text-body-secondary relative z-10 inline-block px-3 text-base text-black'>
          OR
        </span>
      </span>

      <form onSubmit={handleSubmit}>
        <div className='mb-[22px]'>
          <input
            type='text'
            placeholder='Name'
            name='name'
            required
            value={formData.name}
            onChange={handleChange}
            className='w-full rounded-md border border-solid bg-transparent px-5 py-3 text-base text-dark outline-hidden transition border-gray-200 placeholder:text-black/30 focus:border-primary focus-visible:shadow-none text-black'
          />
        </div>
        <div className='mb-[22px]'>
          <input
            type='email'
            placeholder='Email'
            name='email'
            required
            value={formData.email}
            onChange={handleChange}
            className='w-full rounded-md border border-solid bg-transparent px-5 py-3 text-base text-dark outline-hidden transition border-gray-200 placeholder:text-black/30 focus:border-primary focus-visible:shadow-none text-black'
          />
        </div>
        <div className='mb-[22px]'>
          <input
            type='password'
            placeholder='Password'
            name='password'
            required
            value={formData.password}
            onChange={handleChange}
            className='w-full rounded-md border border-solid bg-transparent px-5 py-3 text-base text-dark outline-hidden transition border-gray-200 placeholder:text-black/30 focus:border-primary focus-visible:shadow-none text-black'
          />
        </div>
        <div className='mb-9'>
          <button
            type='submit'
            className='flex w-full items-center text-18 font-medium text-white justify-center rounded-md bg-primary px-5 py-3 text-darkmode transition duration-300 ease-in-out hover:bg-transparent hover:text-primary border-primary border hover:cursor-pointer'>
            Sign Up 
          </button>
        </div>
      </form>


      <p className='text-body-secondary mb-4 text-black/60 text-base'>
        By creating an account you are agree with our{' '}
        <a href='/' className='text-primary hover:underline'>Privacy</a>{' '}
        and{' '}
        <a href='/' className='text-primary hover:underline'>Policy</a>
      </p>

      <p className='text-body-secondary text-black/60 text-base'>
        Already have an account?
        <Link href='/' className='pl-2 text-primary hover:underline'>
          Sign In
        </Link>
      </p>
    </>
  );
};

export default SignUp;