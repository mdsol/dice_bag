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
    all_templates.push(File.join(pwd, "my_template.yml.dice))
    all_templates
  end
end
```
This class has to be load in memory when your rake task is executed.
If you are adding a template to a gem called 'gem_name'. Make sure the file with this
class is loaded from 'lib/gem_name.rb' in your Gem. When the Gem is
required this file will be in memory and Dicebag will find it.

The Template file you need to create will be rendered by ERB. This gives
you flexibility to introduce logic in your template.

You can use the 'configured' object to get the information from
environment variables.
Check the default templates from Dicebag for examples.
