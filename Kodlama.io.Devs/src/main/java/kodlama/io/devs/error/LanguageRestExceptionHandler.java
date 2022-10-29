package kodlama.io.devs.error;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

@ControllerAdvice(basePackages = "kodlama.io.devs")
public class LanguageRestExceptionHandler {
	@ExceptionHandler
	public ResponseEntity<LanguageErrorResponse> handleException(LanguageNotFoundException exception) {

		LanguageErrorResponse error = new LanguageErrorResponse();
		error.setStatus(HttpStatus.NOT_FOUND.value()); // 404, 500..
		error.setMessage(exception.getMessage());
		error.setTimeStamp(System.currentTimeMillis());

		return new ResponseEntity<>(error, HttpStatus.NOT_FOUND);
	}

	@ExceptionHandler
	public ResponseEntity<LanguageErrorResponse> handleException(Exception exception) {

		LanguageErrorResponse error = new LanguageErrorResponse();
		error.setStatus(HttpStatus.BAD_REQUEST.value()); // 404, 500..
		error.setMessage(exception.getMessage());
		error.setTimeStamp(System.currentTimeMillis());

		return new ResponseEntity<>(error, HttpStatus.BAD_REQUEST);
	}
}
