package kodlama.io.devs.error;

import java.time.LocalDateTime;

import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.http.converter.HttpMessageNotReadableException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import org.springframework.web.method.annotation.MethodArgumentTypeMismatchException;

@RestControllerAdvice(basePackages = "kodlama.io.devs")
public class BaseRestExceptionHandler {

	// genel hatalar icin 400 hatasi firlat
	@ExceptionHandler(value = RuntimeException.class)
	public ResponseEntity<?> handleException(RuntimeException exception) {
		BaseErrorResponse error = new BaseErrorResponse();

		// degerleri set et
		error.setStatus(HttpStatus.BAD_REQUEST.value());
		error.setMessage(exception.getMessage());
		error.setTimeStamp(LocalDateTime.now());

		return new ResponseEntity<>(error, HttpStatus.BAD_REQUEST);
	}

	// language bulunamazsa 404 hatasi firlat
	@ExceptionHandler(value = LanguageErrorException.class)
	public ResponseEntity<?> handleException(LanguageErrorException exception) {
		BaseErrorResponse error = new BaseErrorResponse();

		// degeri set et
		error.setStatus(HttpStatus.NOT_FOUND.value());
		error.setMessage(exception.getMessage());
		error.setTimeStamp(LocalDateTime.now());

		return new ResponseEntity<>(error, HttpStatus.NOT_FOUND);
	}

	// technology bulunamazsa 404 hatasi firlat
	@ExceptionHandler(value = TechnologyErrorException.class)
	public ResponseEntity<?> handleException(TechnologyErrorException exception) {
		BaseErrorResponse error = new BaseErrorResponse();

		// degerleri set et
		error.setStatus(HttpStatus.NOT_FOUND.value());
		error.setMessage(exception.getMessage());
		error.setTimeStamp(LocalDateTime.now());

		return new ResponseEntity<>(error, HttpStatus.NOT_FOUND);
	}

	// id degeri int degilse 406 hatasi firlat
	@ExceptionHandler(value = MethodArgumentTypeMismatchException.class)
	public ResponseEntity<?> handleException(MethodArgumentTypeMismatchException exception) {
		BaseErrorResponse error = new BaseErrorResponse();

		// degerleri set et
		error.setStatus(HttpStatus.NOT_ACCEPTABLE.value());
		error.setMessage("Integer veri giriniz. Girilen veri: " + exception.getValue());
		error.setTimeStamp(LocalDateTime.now());

		return new ResponseEntity<>(error, HttpStatus.NOT_ACCEPTABLE);
	}

	// foreign key null girilirse 400 hatasi firlat ve unique degeri kontrolu
	@ExceptionHandler(value = DataIntegrityViolationException.class)
	public ResponseEntity<?> handleException(DataIntegrityViolationException exception) {
		BaseErrorResponse error = new BaseErrorResponse();

		// degerleri set et
		error.setStatus(HttpStatus.BAD_REQUEST.value());
		error.setMessage("Girilen değer kabul edilemez: " + exception.getRootCause());
		error.setTimeStamp(LocalDateTime.now());

		return new ResponseEntity<>(error, HttpStatus.BAD_REQUEST);
	}

	// null deger girilirse ise 400 hatasi firlat
	@ExceptionHandler(value = NullPointerException.class)
	public ResponseEntity<?> handleException(NullPointerException exception) {
		BaseErrorResponse error = new BaseErrorResponse();

		// degerleri set et
		error.setStatus(HttpStatus.BAD_REQUEST.value());
		error.setMessage("Girilen değer kabul edilemez: " + exception.getCause());
		error.setTimeStamp(LocalDateTime.now());

		return new ResponseEntity<>(error, HttpStatus.BAD_REQUEST);
	}

	// jsona hicbir sey girilmez ise 400 hatasi firlat
	@ExceptionHandler(value = HttpMessageNotReadableException.class)
	public ResponseEntity<?> handleException(HttpMessageNotReadableException exception) {
		BaseErrorResponse error = new BaseErrorResponse();

		// degerleri set et
		error.setStatus(HttpStatus.BAD_REQUEST.value());
		error.setMessage("JSON ayrıştırma hatası.");
		error.setTimeStamp(LocalDateTime.now());

		return new ResponseEntity<>(error, HttpStatus.BAD_REQUEST);
	}
}
