package cyhy.aviseditor;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.List;

public class EditorIntegration {
    private final List<String> commentTemplates = new ArrayList<>();

    public void loadCommentTemplates(Path commentFilePath) throws IOException {
        if (!Files.exists(commentFilePath)) {
            throw new java.io.FileNotFoundException("Target comment blueprint script file not found.");
        }
        
        List<String> lines = Files.readAllLines(commentFilePath);
        StringBuilder currentTemplate = new StringBuilder();
        boolean insideTemplate = false;

        for (String line : lines) {
            line = line.trim();
            if (line.startsWith("define_comment_template")) {
                insideTemplate = true;
                currentTemplate.setLength(0);
                continue;
            }
            if (insideTemplate) {
                if (line.endsWith("]")) {
                    insideTemplate = false;
                    commentTemplates.add(currentTemplate.toString());
                } else {
                    currentTemplate.append(line).append(System.lineSeparator());
                }
            }
        }
    }

    public List<String> getRegisteredTemplates() {
        return this.commentTemplates;
    }
}
