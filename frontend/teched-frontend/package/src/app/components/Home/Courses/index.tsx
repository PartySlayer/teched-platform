'use client'

import { useEffect, useState } from 'react'
import Link from 'next/link'
import Image from 'next/image'
import { Icon } from '@iconify/react'
import Slider from 'react-slick'
import 'slick-carousel/slick/slick.css'
import 'slick-carousel/slick/slick-theme.css'
import { CourseType } from '@/app/types/course'
import CourseSkeleton from '../../Skeleton/Course'

const Courses = () => {
  const [course, setCourse] = useState<CourseType[]>([])
  const [loading, setLoading] = useState(true)

  // Funzione per recuperare i dati dal tuo microservizio Java
  const fetchCoursesFromBackend = async () => {
    setLoading(true)
    try {
      // Nota: Qui usiamo l'URL del tuo AuthService o LearnService su Docker
      const res = await fetch('http://localhost:8080/auth/test-email?email=test@test.com') 
      if (!res.ok) throw new Error('Errore nel recupero dati')
      // Aggiungi qui la logica per mappare i dati dal backend se necessario
    } catch (error) {
      console.error('Errore backend:', error)
    } finally {
      setLoading(false)
    }
  }

  useEffect(() => {
    const fetchData = async () => {
      try {
        const res = await fetch('/api/data')
        if (!res.ok) throw new Error('Failed to fetch')
        const data = await res.json()
        setCourse(data.CourseData)
      } catch (error) {
        console.error('Error fetching data:', error)
      } finally {
        setLoading(false)
      }
    }
    fetchData()
  }, [])

  const settings = {
    dots: true,
    infinite: true,
    slidesToShow: 3,
    slidesToScroll: 1,
    arrows: false,
    autoplay: true,
    speed: 500,
    responsive: [
      { breakpoint: 1200, settings: { slidesToShow: 2 } },
      { breakpoint: 600, settings: { slidesToShow: 1 } },
    ],
  }

  const renderStars = (rating: number) => {
    return (
      <div className="flex">
        {[...Array(5)].map((_, i) => (
          <Icon
            key={i}
            icon='tabler:star-filled'
            className={`text-xl ${i < Math.floor(rating) ? 'text-yellow-500' : 'text-gray-300'}`}
          />
        ))}
      </div>
    )
  }

  return (
    <section id='courses' className='scroll-mt-12 pb-20'>
      <div className='container mx-auto px-4'>
        <div className='sm:flex justify-between items-center mb-10'>
          <h2 className='text-3xl font-bold text-midnight_text'>Popular Courses</h2>
          <button 
            onClick={() => fetchCoursesFromBackend()} // Corretto: chiamata tramite arrow function
            className='text-primary text-lg font-medium hover:underline'>
            Refresh Backend Data &gt;
          </button>
        </div>

        <Slider {...settings}>
          {loading
            ? Array.from({ length: 3 }).map((_, i) => <CourseSkeleton key={i} />)
            : course.map((items, i) => (
                <div key={i} className='p-2'>
                  <div className='bg-white p-4 shadow-lg rounded-2xl border border-gray-100 h-full'>
                    <div className='relative overflow-hidden rounded-xl'>
                      <Image
                        src={items.imgSrc}
                        alt={items.heading}
                        width={400}
                        height={250}
                        className='object-cover w-full h-48'
                      />
                      <div className='absolute top-2 right-2 bg-secondary text-white text-xs px-3 py-1 rounded-full'>
                        BEST SELLER
                      </div>
                    </div>

                    <div className='mt-4'>
                      <h3 className='text-lg font-bold line-clamp-2'>{items.heading}</h3>
                      <p className='text-gray-500 text-sm mt-1'>{items.name}</p>
                      
                      <div className='flex justify-between items-center mt-4 pt-4 border-t border-gray-100'>
                        <div className='flex items-center gap-2'>
                          <span className='font-bold text-red-600'>{items.rating.toFixed(1)}</span>
                          {renderStars(items.rating)}
                        </div>
                        <span className='text-2xl font-bold'>${items.price}</span>
                      </div>

                      <div className='flex justify-between mt-4 text-sm text-gray-600 font-medium'>
                        <div className='flex items-center gap-1'>
                          <Icon icon='solar:notebook-minimalistic-outline' className='text-primary' />
                          {items.classes} Classes
                        </div>
                        <div className='flex items-center gap-1'>
                          <Icon icon='solar:users-group-rounded-linear' className='text-primary' />
                          {items.students} Students
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              ))}
        </Slider>
      </div>
    </section>
  )
}

export default Courses