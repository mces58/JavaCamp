package kodlama.io.devs.error;

// Language hata sinifi
public class LanguageErrorException extends RuntimeException {
	private static final long serialVersionUID = 1L;

	public LanguageErrorException() {
		super();

	}

	public LanguageErrorException(String message, Throwable cause, boolean enableSuppression,
			boolean writableStackTrace) {
		super(message, cause, enableSuppression, writableStackTrace);

	}

	public LanguageErrorException(String message, Throwable cause) {
		super(message, cause);

	}

	public LanguageErrorException(String message) {
		super(message);

	}

	public LanguageErrorException(Throwable cause) {
		super(cause);

	}

}
