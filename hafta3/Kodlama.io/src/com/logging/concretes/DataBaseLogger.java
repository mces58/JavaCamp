package com.logging.concretes;

import com.logging.abstracts.Logger;

public class DataBaseLogger implements Logger {

	@Override
	public void log(String data) {
		System.out.println("Logging to database: " + data);

	}

}
