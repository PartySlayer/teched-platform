'use client'

import { useEffect, useState } from 'react'
import Image from 'next/image'
import { Icon } from '@iconify/react'
import Slider from 'react-slick'
import 'slick-carousel/slick/slick.css'
import 'slick-carousel/slick/slick-theme.css'
import { CourseType } from '@/app/types/course'
import CourseSkeleton from '../../Skeleton/Course'

interface CoursesProps {
  isGrid?: boolean;
}

const Courses = ({ isGrid = false }: CoursesProps) => {
  const [course, setCourse] = useState<CourseType[]>([])
  const [loading, setLoading] = useState(true)

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
    infinite: course.length > 3,
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

  const renderStars = (rating: number) => (
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

  // Funzione helper per renderizzare la singola Card
  const renderCard = (items: CourseType, index: number) => (
    <div key={index} className={isGrid ? 'w-full' : 'p-2'}>
      <div className='bg-white p-4 shadow-lg rounded-2xl border border-gray-100 h-full flex flex-col'>
        <div className='relative overflow-hidden rounded-xl'>
          <Image
            src={items.imgSrc}
            alt={items.heading}
            width={400}
            height={250}
            className='object-cover w-full h-48'
          />
          <div className='absolute top-2 right-2 bg-secondary text-white text-xs px-3 py-1 rounded-full font-bold'>
            BEST SELLER
          </div>
        </div>

        <div className='mt-4 flex-grow'>
          <h3 className='text-lg font-bold line-clamp-2 h-14'>{items.heading}</h3>
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
              <Icon icon='solar:notebook-minimalistic-outline' className='text-primary text-lg' />
              {items.classes} Classes
            </div>
            <div className='flex items-center gap-1'>
              <Icon icon='solar:users-group-rounded-linear' className='text-primary text-lg' />
              {items.students} Students
            </div>
          </div>
        </div>
      </div>
    </div>
  )

  return (
    <section id='courses' className={`scroll-mt-12 pb-20 ${isGrid ? 'pt-32' : 'pt-10'}`}>
      <div className='container mx-auto px-4'>
        <div className='sm:flex justify-between items-center mb-10'>
          <h2 className='text-3xl font-bold text-midnight_text'>
            {isGrid ? 'All Courses' : 'Popular Courses'}
          </h2>
          {!isGrid && (
            <button className='text-primary text-lg font-medium hover:underline flex items-center gap-1'>
              View All <Icon icon="lucide:chevron-right" />
            </button>
          )}
        </div>

        {loading ? (
          <div className={isGrid ? 'grid grid-cols-1 md:grid-cols-3 gap-6' : ''}>
            {isGrid ? (
              Array.from({ length: 6 }).map((_, i) => <CourseSkeleton key={i} />)
            ) : (
              <Slider {...settings}>
                {Array.from({ length: 3 }).map((_, i) => <CourseSkeleton key={i} />)}
              </Slider>
            )}
          </div>
        ) : (
          <>
            {isGrid ? (
              <div className='grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-8'>
                {course.map((item, i) => renderCard(item, i))}
              </div>
            ) : (
              <Slider {...settings}>
                {course.map((item, i) => renderCard(item, i))}
              </Slider>
            )}
          </>
        )}
      </div>
    </section>
  )
}

export default Courses