class Validator {
  email(value, message) {
    let emailLen = value ? value.trim().length : 0;
    if (emailLen < 1 || emailLen > 50 || !value?.includes("@")) {
      return {
        field: "email",
        name: "email",
        message: message,
      };
    } else {
      return {
        field: "email",
        name: "email",
        message: "",
      };
    }
  }
  password(value, message) {
    let passwordLen = value ? value.trim().length : 0;
    if (passwordLen < 1) {
      return {
        field: "password",
        name: "password",
        message: message,
      };
    } else {
      return {
        field: "password",
        name: "password",
        message: "",
      };
    }
  }
  latitude(value, message) {
    let latitude = parseFloat(value);
    return {
      field: "latitude",
      name: "latitude",
      message: (!isNaN(latitude) && latitude >= 0 && latitude <= 90) ? "" : message,
    };
  }
  longitude(value, message) {
    let longitude = parseFloat(value);
    return {
      field: "longitude",
      name: "longitude",
      message: (!isNaN(longitude) && longitude >= 0 && longitude <= 180) ? "" : message,
    };
  }
  endpoint(value, message) {
    const ipPortPart = value.split(`/`)[0];
    const [ ipPart, portPart ] = ipPortPart.split(`:`);
    const portParsed = parseInt(portPart);
    const ipNumbers = ipPart.split(".")
    const isValid = !isNaN(portParsed) && portParsed <= 65535 && portParsed > 0 && ipNumbers.length === 4 && !ipNumbers.some((ipStrRaw) => {
      const ipNumber = parseInt(ipStrRaw);
      return isNaN(ipNumber) || ipNumber > 255 || ipNumber < 0;
    });
    return {
      field: "endpoint",
      name: "endpoint",
      message: isValid ? "" : "Endpoint must be a string in format  \"{camera ip}:{camera port}/#{possibly some path}\"",
    };
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
      case "latitude":
        messageArray.push(
          validator.latitude(
            getValueForRule(fields, rule.fieldName),
            rule.message
          )
        );
        break;
      case "longitude":
        messageArray.push(
          validator.longitude(
            getValueForRule(fields, rule.fieldName),
            rule.message
          )
        );
        break;
      case "endpoint":
        messageArray.push(
          validator.endpoint(
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
