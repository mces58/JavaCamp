package kodlama.io.devs.business.response;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class TechnologyResponse {
	private int technologyId;
	private int languageId;
	private String technologyName;
}
