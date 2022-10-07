package com.logging.concretes;

import com.logging.abstracts.Logger;

public class MailLogger implements Logger {

	@Override
	public void log(String data) {
		System.out.println("Send to mail: " + data);

	}

}
