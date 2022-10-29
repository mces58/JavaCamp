package kodlama.io.devs.error;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class LanguageErrorResponse {
	private int status;
	private String message;
	private long timeStamp;
}
