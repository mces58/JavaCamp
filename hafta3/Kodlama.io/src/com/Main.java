package com;

import java.util.ArrayList;
import java.util.List;

import com.business.abstracts.CourseService;
import com.business.concretes.CourseManager;
import com.dataAccess.abstracts.CourseDAO;
import com.dataAccess.concretes.HibernateCourseDAO;
import com.entities.Course;
import com.logging.abstracts.Logger;
import com.logging.concretes.DataBaseLogger;
import com.logging.concretes.FileLogger;
import com.logging.concretes.MailLogger;

public class Main {
	public static void main(String[] args) throws Exception {
		Course course = new Course(1, "Java", 200, "Coding", "Can");
		Course course2 = new Course(2, "Data Structures", 300, "Algorithm", "Can");
		CourseDAO courseDAO = new HibernateCourseDAO();

		Logger dataBaseLogger = new DataBaseLogger();
		Logger fileLogger = new FileLogger();
		Logger mailLogger = new MailLogger();

		List<Logger> loggers = new ArrayList<>();
		loggers.add(dataBaseLogger);
		loggers.add(fileLogger);
		loggers.add(mailLogger);

		CourseService courseService = new CourseManager(courseDAO, loggers);

		courseService.addCourse(course);
		courseService.addCourse(course2);

		courseService.printLoggers();
		courseService.printCourses();

		courseService.deleteCourse(course2);
		courseService.printCourses();

	}
}
