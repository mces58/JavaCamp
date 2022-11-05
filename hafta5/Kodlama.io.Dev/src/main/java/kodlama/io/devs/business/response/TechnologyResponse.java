package kodlama.io.devs.business.response;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class TechnologyResponse {
	// kullaniciya id, name, releaseYear ve languageName verilerini goster
	private int id;
	private String name;
	private Date releaseYear;
	private String languageName;
}
