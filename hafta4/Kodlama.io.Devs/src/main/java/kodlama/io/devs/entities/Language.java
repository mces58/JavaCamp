package kodlama.io.devs.entities;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Language {
	private int languageId;
	private String languageName;
	private String languageLevel;
	private String usageAreas;

}
