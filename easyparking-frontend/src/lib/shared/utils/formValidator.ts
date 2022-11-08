class Validator {
  email(value, message) {
    let emailLen = value ? value.trim().length : 0;
    if (emailLen < 1 || emailLen > 50 || !value?.includes("@")) {
      return {
        field: "email",
        message: message,
      };
    } else {
      return {
        field: "email",
        message: "",
      };
    }
  }
  password(value, message) {
    let passwordLen = value ? value.trim().length : 0;
    if (passwordLen < 1) {
      return {
        field: "password",
        message: message,
      };
    } else {
      return {
        field: "password",
        message: "",
      };
    }
  }
}

interface Field {
  type: string;
  name: string;
  value: string;
}

interface Rule {
  type: string;
  fieldName: string;
  message: string;
}

const getValueForRule = (fields: Field[], ruleName: string) => {
  const field = fields.find((field: Field) => field.name === ruleName);
  return field?.value;
};

export function formValidation(fields: Field[], rules: Rule[]) {
  const validator = new Validator();
  let isValid = true;
  const messageArray = [];
  for (let rule of rules) {
    switch (rule.type) {
      case "email":
        messageArray.push(
          validator.email(getValueForRule(fields, rule.fieldName), rule.message)
        );
        break;
      case "password":
        messageArray.push(
          validator.password(
            getValueForRule(fields, rule.fieldName),
            rule.message
          )
        );
        break;
      default:
        isValid = true;
    }
  }
  for (let item of messageArray) {
    if (item.message) isValid = false;
  }
  return [isValid, messageArray];
}
