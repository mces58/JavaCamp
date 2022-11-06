package kodlama.io.devs.business.responses;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonInclude.Include;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@JsonInclude(value = Include.NON_NULL) // message degeri null degeri aldiginda gorunmesin
public class TechnologyResponse {
	// kullaniciya id, name, releaseYear ve languageName verilerini goster

	private String message;
	private int id;
	private String name;
	@JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "dd-MM-yyyy") // kullanicidan alinacak tarih formati
	private Date releaseYear;
	private String languageName;
}
