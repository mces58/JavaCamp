package kodlama.io.devs.error;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

// @ControllerAdvice istemci tarafina iletilecek olan exceptionlari 
// yoneterek global exception handling yapmamiza olanak tanimistir. 
// Bu anotasyonu kullarak uygulamamizin herhangi bir noktasindan firlatilan 
// ve Controller’lar uzerinden istemciye iletilen hatalarin tiplerini 
// donusturebilir, farkli HTTP statu kodlarini kullanarak ozellestirebilir 
// veya ihtiyaclar dogrultusunda degistirdigimiz cevaplari istemci tarafina iletebiliriz
@ControllerAdvice(basePackages = "kodlama.io.devs")
public class LanguageRestExceptionHandler {

	// id degeri yok ise status olarak not_found deger donder
	@ExceptionHandler
	public ResponseEntity<?> handleException(LanguageNotFoundException exception) {
		// hata bilgileri sinifini newle
		LanguageErrorResponse error = new LanguageErrorResponse();

		// hata degerlerini ata
		error.setStatus(HttpStatus.NOT_FOUND.value());
		error.setMessage(exception.getMessage());
		error.setTimeStamp(System.currentTimeMillis());

		// geri donder
		return new ResponseEntity<>(error, HttpStatus.NOT_FOUND);
	}

	// bad request islemi olursa bu fonksiyon calisacak
	@ExceptionHandler
	public ResponseEntity<?> handleException(Exception exception) {
		// hata bilgileri sinifini newle
		LanguageErrorResponse error = new LanguageErrorResponse();

		// hata degerlerini ata
		error.setStatus(HttpStatus.BAD_REQUEST.value());
		error.setMessage(exception.getMessage());
		error.setTimeStamp(System.currentTimeMillis());

		// geri donder
		return new ResponseEntity<>(error, HttpStatus.BAD_REQUEST);
	}
}
