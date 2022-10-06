package com.entities;

public class Course {

	// fields
	private int id;
	private String name;
	private double unitPrice;
	private String category;
	private String instructor;

	// default constructor
	public Course() {

	}

	// param constructor
	public Course(int id, String name, double unitPrice, String category, String instructor) {
		this.id = id;
		this.name = name;
		this.unitPrice = unitPrice;
		this.category = category;
		this.instructor = instructor;
	}

	// getter and setter
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public double getUnitPrice() {
		return unitPrice;
	}

	public void setUnitPrice(double unitPrice) {
		this.unitPrice = unitPrice;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public String getInstructor() {
		return instructor;
	}

	public void setInstructor(String instructor) {
		this.instructor = instructor;
	}

}
