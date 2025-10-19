package co.wali.env_sec;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class PGconnection {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @GetMapping("/test-pg-conn")
    public String testPg(){
        try {
            String result = jdbcTemplate.queryForObject("SELECT version()", String.class);
            return "✅ PostgreSQL Connected! <br>Version: <pre>" + result + "</pre>";
        } catch (Exception e) {
            return "❌ Database connection failed: " + e.getMessage();
        }
    }
}
