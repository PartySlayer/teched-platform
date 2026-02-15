import Image from 'next/image';
import CourseContent from '@/app/components/CourseDetails/CourseContent';
// Interfaccia per i dati (se usi TypeScript, aiuta a non fare errori)
interface Lesson {
  id: string;
  title: string;
  duration: string;
  videoId: string;
}

export default async function CourseDetails({ params }: { params: { id: string } }) {
  const { id } = params;

  // Mock dei dati (Sostituirai questo con la fetch verso Spring Boot)
  const courseData = {
    title: "Sviluppo Web Moderno con React",
    description: "Impara a costruire applicazioni scalabili partendo da zero fino al deployment professionale.",
    price: 34,
    oldPrice: 99,
    lessons: [
      { id: "1", title: "Introduzione al corso", duration: "05:20", videoId: "dQw4w9WgXcQ" },
      { id: "2", title: "Setup dell'ambiente di lavoro", duration: "12:45", videoId: "30LWjhZzg50" },
      { id: "3", title: "I segreti di Next.js 14", duration: "15:10", videoId: "SqcY0GlETPk" },
      { id: "4", title: "Integrazione con Spring Boot", duration: "20:00", videoId: "dQw4w9WgXcQ" },
    ]
  };

  return (
    <main className="pt-32 pb-20 container mx-auto px-4">
      <div className="grid grid-cols-1 lg:grid-cols-3 gap-12">
        
        {/* COLONNA SINISTRA: Player Interattivo e Lezioni */}
        <div className="lg:col-span-2">
          <CourseContent 
            title={courseData.title} 
            description={courseData.description} 
            lessons={courseData.lessons} 
          />
        </div>

        {/* COLONNA DESTRA: Card Acquisto Sticky */}
        <div className="lg:col-span-1">
          <div className="sticky top-32 bg-white p-6 shadow-2xl rounded-3xl border border-gray-100">
            {/* Anteprima Immagine con tasto Play */}
            <div className="relative h-52 w-full rounded-2xl overflow-hidden mb-6 group">
               <Image 
                src="/assets/courses/coursesOne.png" 
                alt="Preview Corso" 
                fill 
                className="object-cover transition-transform duration-500 group-hover:scale-110" 
               />
               <div className="absolute inset-0 bg-black/30 flex items-center justify-center">
                  <div className="bg-white/90 p-4 rounded-full shadow-xl">
                    <svg className="w-8 h-8 text-primary" fill="currentColor" viewBox="0 0 20 20">
                        <path d="M6.3 2.841A1.5 1.5 0 004 4.11V15.89a1.5 1.5 0 002.3 1.269l9.333-5.89a1.5 1.5 0 000-2.538L6.3 2.841z"/>
                    </svg>
                  </div>
               </div>
            </div>
            
            <div className="flex items-baseline justify-between mb-6">
              <span className="text-4xl font-black text-midnight_text">${courseData.price}</span>
              <span className="text-lg line-through text-gray-400">${courseData.oldPrice}</span>
            </div>

            <button className="w-full bg-primary text-white py-4 rounded-2xl font-bold text-lg hover:shadow-primary/30 hover:shadow-lg transition-all mb-6">
              Iscriviti Ora
            </button>
            
            <div className="space-y-4">
              <p className="font-bold text-sm text-midnight_text uppercase tracking-wider">Il corso include:</p>
              <ul className="space-y-2">
                <li className="flex items-center gap-3 text-gray-600 text-sm">
                  <span className="text-green-500 font-bold">✓</span> Accesso a vita
                </li>
                <li className="flex items-center gap-3 text-gray-600 text-sm">
                  <span className="text-green-500 font-bold">✓</span> Certificato di completamento
                </li>
                <li className="flex items-center gap-3 text-gray-600 text-sm">
                  <span className="text-green-500 font-bold">✓</span> Supporto diretto Mentor
                </li>
              </ul>
            </div>
          </div>
        </div>

      </div>
    </main>
  );
}