package com.dataAccess.abstracts;

import com.entities.Course;

public interface CourseDAO {
	// add course
	void addCourse(Course course);

	// delete course
	void deleteCourse(Course course);
}
