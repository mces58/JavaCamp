package kodlama.io.devs.business.response;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class LanguageResponse {
	// kullaniciya id, name ve level verilerini goster
	private int id;
	private String name;
	private String level;
}
