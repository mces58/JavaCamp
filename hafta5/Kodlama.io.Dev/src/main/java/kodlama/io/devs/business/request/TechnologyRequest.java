package kodlama.io.devs.business.request;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class TechnologyRequest {
	// kullanicidan name, releaseYear ve languageName verileri al
	private String name;
	private Date releaseYear;
	private String languageName;
}
