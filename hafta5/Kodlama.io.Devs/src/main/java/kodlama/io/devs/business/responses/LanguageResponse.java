package kodlama.io.devs.business.responses;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonInclude.Include;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@JsonInclude(value = Include.NON_NULL) // message null degeri aldiginda gorunmesin
public class LanguageResponse {
	// kullaniciya id, name ve level verilerini goster

	private String message;
	private int id;
	private String name;
	private String level;
}
