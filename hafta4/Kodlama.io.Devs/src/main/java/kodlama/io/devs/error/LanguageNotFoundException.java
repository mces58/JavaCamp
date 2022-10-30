package kodlama.io.devs.error;

// kendi ozel hata sinifimiz 
// RuntimeException classini miras alir
public class LanguageNotFoundException extends RuntimeException {
	private static final long serialVersionUID = 1L;

	public LanguageNotFoundException() {
		super();
	}

	public LanguageNotFoundException(String message, Throwable cause, boolean enableSuppression,
			boolean writableStackTrace) {
		super(message, cause, enableSuppression, writableStackTrace);
	}

	public LanguageNotFoundException(String message, Throwable cause) {
		super(message, cause);
	}

	public LanguageNotFoundException(String message) {
		super(message);
	}

	public LanguageNotFoundException(Throwable cause) {
		super(cause);
	}

}
