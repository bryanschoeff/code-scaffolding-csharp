{{#each tables}}
using System;
using System.ComponentModel.DataAnnotations;

namespace {{applicationName}}.Models
{
    public class {{className}}
    {
        public int ID { get; set; }
        {{#each fields}}
        [Display(Name = "{{name}}"){{#if isString}}, DisplayFormat(ConvertEmptyStringToNull = false){{/if}}]
        public {{csharpType}} {{csharpName}} { get; set; }{{/each}}
        [Display(Name = "Created")]
        public DateTime Created { get; set; }
        [Display(Name = "Last Modified")]
        public DateTime LastModified { get; set; }

        public {{className}}()
        {
          this.ID = -1;
        }
    }
}
{{/each}}
