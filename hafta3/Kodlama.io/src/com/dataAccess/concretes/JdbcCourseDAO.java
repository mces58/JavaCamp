package com.dataAccess.concretes;

import com.dataAccess.abstracts.CourseDAO;
import com.entities.Course;

public class JdbcCourseDAO implements CourseDAO {

	// add course with JDBC
	@Override
	public void addCourse(Course course) {
		System.out.println("Added to course database with JDBC");

	}

	// delete course with JDBC
	@Override
	public void deleteCourse(Course course) {
		System.out.println("Deleted from course database with JDBC");

	}

}
