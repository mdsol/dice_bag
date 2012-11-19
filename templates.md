## Define your own templates

Dice bag comes with templates for common configuration files.
You can execute:
```ruby
rake config:generate_all
```
to generate templates for the configuration files of your project.

If you want to add your own templates to be generated with this command
you can create your own gem or a file in your project where you have a
class inheriting from DiceBag::AvailableTemplates.
This class will have a method called templates.
This method returns an array of strings. Each string will
be the full path location of one template.
Example:

```ruby
class MyTemplates << Dicebag::AvailableTemplates
  def templates
    all_templates = []
    pwd = File.dirname(__FILE__)
    all_templates.push(File.join(pwd, "my_template.yml.erb))
    all_templates
  end
end
```
