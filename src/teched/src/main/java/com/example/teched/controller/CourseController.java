package com.example.teched.controller;

import com.example.teched.api.CoursesApi;
import com.example.teched.api.CoursesApi;
import com.example.teched.model.ContentUnit;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RestController;
import java.util.List;
import java.util.ArrayList;



    @RestController
    public class CourseController implements CoursesApi {

        @Override
        public ResponseEntity<List<ContentUnit>> coursesGet() {
            // Implementazione di prova
            List<ContentUnit> list = new ArrayList<>();
            return ResponseEntity.ok(list);
        }
    }

