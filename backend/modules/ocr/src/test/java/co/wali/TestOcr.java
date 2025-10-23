package co.wali;

import org.springframework.boot.SpringApplication;

public class TestOcr {

	public static void main(String[] args) {
		SpringApplication.from(Ocr::main).with(TestcontainersConfiguration.class).run(args);
	}

}
