package kodlama.io.devs.error;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

// hata bilgilerinin tutacagi sinif
// amacimiz hatalari json formatinda yazdirmak
@Data
@NoArgsConstructor
@AllArgsConstructor
public class LanguageErrorResponse {
	// http status code: 404, 400, 200...
	private int status;

	// hata mesaji
	private String message;

	// zaman asimi
	private long timeStamp;
}
