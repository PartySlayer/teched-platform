'use client'
import { useState } from 'react';
import { Icon } from '@iconify/react';

export default function CourseContent({ title, description, lessons }: any) {
  const [activeVideo, setActiveVideo] = useState(lessons[0]?.videoId);

  return (
    <div className="space-y-8">
      {/* 1. VIDEO PLAYER */}
      <div className="aspect-video bg-black rounded-3xl overflow-hidden shadow-xl border-4 border-white">
        <iframe
          className="w-full h-full"
          src={`https://www.youtube.com/embed/${activeVideo}?rel=0&showinfo=0`}
          allowFullScreen
        />
      </div>

      {/* 2. INFO TESTUALI */}
      <div>
        <h1 className="text-3xl font-bold text-midnight_text">{title}</h1>
        <p className="text-gray-600 mt-3 leading-relaxed">{description}</p>
      </div>

      {/* 3. LISTA LEZIONI (SYLLABUS) */}
      <div className="mt-10">
        <h2 className="text-2xl font-bold mb-6 flex items-center gap-2">
          <Icon icon="solar:playlist-minimalistic-bold" className="text-primary" />
          Contenuto del corso
        </h2>
        
        <div className="space-y-3">
          {lessons.map((lesson: any, index: number) => (
            <button
              key={lesson.id}
              onClick={() => setActiveVideo(lesson.videoId)}
              className={`w-full flex items-center justify-between p-5 rounded-2xl border transition-all ${
                activeVideo === lesson.videoId 
                ? 'border-primary bg-primary/5 shadow-md shadow-primary/10' 
                : 'border-gray-100 bg-white hover:border-gray-300'
              }`}
            >
              <div className="flex items-center gap-4">
                <div className={`p-2 rounded-full ${activeVideo === lesson.videoId ? 'bg-primary text-white' : 'bg-gray-100 text-gray-400'}`}>
                  <Icon icon="solar:play-bold" />
                </div>
                <div className="text-left">
                  <span className="text-xs font-bold text-primary uppercase tracking-wider">Lezione {index + 1}</span>
                  <h4 className={`font-bold ${activeVideo === lesson.videoId ? 'text-primary' : 'text-midnight_text'}`}>
                    {lesson.title}
                  </h4>
                </div>
              </div>
              <span className="text-sm font-mono font-medium text-gray-400">{lesson.duration}</span>
            </button>
          ))}
        </div>
      </div>
    </div>
  );
}