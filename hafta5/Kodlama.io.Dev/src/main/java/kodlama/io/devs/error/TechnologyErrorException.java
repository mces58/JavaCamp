package kodlama.io.devs.error;

// Technology hata sinifi
public class TechnologyErrorException extends RuntimeException {
	private static final long serialVersionUID = 1L;

	public TechnologyErrorException() {
		super();
	}

	public TechnologyErrorException(String message, Throwable cause, boolean enableSuppression,
			boolean writableStackTrace) {
		super(message, cause, enableSuppression, writableStackTrace);
	}

	public TechnologyErrorException(String message, Throwable cause) {
		super(message, cause);
	}

	public TechnologyErrorException(String message) {
		super(message);
	}

	public TechnologyErrorException(Throwable cause) {
		super(cause);
	}

}
