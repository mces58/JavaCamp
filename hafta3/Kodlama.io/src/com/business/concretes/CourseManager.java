package com.business.concretes;

import java.util.ArrayList;
import java.util.List;

import com.business.abstracts.CourseService;
import com.dataAccess.abstracts.CourseDAO;
import com.entities.Course;
import com.logging.abstracts.Logger;

public class CourseManager implements CourseService {
	// HibernateCourseDAO.class or JdbcCourseDAO.class
	private CourseDAO courseDAO;

	// DataBaseLogger.clas, FileLogger.class or MailLogger.class
	private List<Logger> loggers;

	// list of courses
	private List<Course> courses;

	// default constructor
	public CourseManager() {

	}

	// param constructor
	public CourseManager(CourseDAO courseDAO, List<Logger> loggers) {
		this.courses = new ArrayList<>();
		this.loggers = loggers;
		this.courseDAO = courseDAO;
	}

	// add course
	@Override
	public void addCourse(Course course) throws Exception {
		if (course.getUnitPrice() < 0) {
			throw new Exception("Course price can not be less than 0");
		}

		for (Course c : courses) {
			if (c.getCategory().equals(course.getCategory())) {
				throw new Exception("Course category can not be the same");
			}
			if (c.getName().equals(course.getName())) {
				throw new Exception("Course name can not be the same");
			}
		}
		courseDAO.addCourse(course);
		courses.add(course);
	}

	// delete course
	@Override
	public void deleteCourse(Course course) {
		this.courses.remove(course);
		System.out.println("Deleted course: " + course.getName());
	}

	// display loggers
	@Override
	public void printCourses() {
		for (Course course : courses) {
			System.out.println(
					"Course id: " + course.getId() + 
					"\nCourse category: " + course.getCategory() + 
					"\nCourse name: " + course.getName() + 
					"\nCourse instructor: " + course.getInstructor() + 
					"\nCourse unit price: " + course.getUnitPrice()
					);

		}
	}

	// display loggers
	@Override
	public void printLoggers() {
		for (Logger logger : loggers) {
			logger.log("Logging");

		}
	}

}
