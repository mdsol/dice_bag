module DiceBag
  class Warning
    def initialize(template_filename)
      @template_filename = template_filename
    end

    def as_ruby_comment
      lines.map { |line| "# #{line}".rstrip }.join("\n") + "\n"
    end

    alias :as_yaml_comment :as_ruby_comment

    def as_xml_comment
      ["<!--", lines, "-->"].flatten.join("\n")
    end

    protected

    def lines
      [
        "WARNING! Do not modify this file directly. It was generated from the",
        "'#@template_filename' template file.",
        "",
        "Use the rake config task to reconfigure. See the template file for",
        "further guidance."
      ]
    end
  end
end
