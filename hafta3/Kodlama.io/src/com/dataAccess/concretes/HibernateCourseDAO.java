package com.dataAccess.concretes;

import com.dataAccess.abstracts.CourseDAO;
import com.entities.Course;

public class HibernateCourseDAO implements CourseDAO {

	// add course with Hibernate
	@Override
	public void addCourse(Course course) {
		System.out.println("Added to course database with hibernate");

	}

	// delete course with Hibernate
	@Override
	public void deleteCourse(Course course) {
		System.out.println("Deleted from course database with hibernate");
	}

}
