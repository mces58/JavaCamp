package com.logging.concretes;

import com.logging.abstracts.Logger;

public class FileLogger implements Logger {

	@Override
	public void log(String data) {
		System.out.println("Logging to file: " + data);

	}

}
