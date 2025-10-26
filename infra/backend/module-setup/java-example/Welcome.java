package co.wali;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.info.BuildProperties;
import org.springframework.core.env.Environment;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.nio.file.Path;

@RestController
public class Welcome {
    @Value("${spring.application.name}")
    private String appName;

    @GetMapping("/")
    public String mainPage() {
        return String.format("""
            <div style="display: flex; justify-content: center; align-items: center; height: 100vh;">
                <h2>Welcome to %s</h2>
            </div>
        """, appName);
    }
}
