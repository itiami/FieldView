package co.wali;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Component;

@Component
public class AppConfig {
    @Autowired
    private Environment env;

    public String getAppName() {
        return env.getProperty("spring.application.name");
    }
}