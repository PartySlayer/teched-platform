import React from "react";
import Courses from "@/app/components/Home/Courses";

export default function Home() {
  return (
    <main className="py-20">
        <Courses isGrid={true} />
    </main>

  );
}