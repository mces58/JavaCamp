package com.business.abstracts;

import com.entities.Course;

public interface CourseService {
	// add course
	void addCourse(Course course) throws Exception;

	// delete course
	void deleteCourse(Course course);

	// display courses
	void printCourses();

	// display loggers
	void printLoggers();

}
