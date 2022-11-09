const EMAIL_MAX_LEN = 50;
const MAX_LATITUDE = 90;
const MAX_LONGITUDE = 180;
const MAX_PORT = 65535;
const IP_LEN = 4;
const MAX_IP_NUMBER = 255;
import type { Field, Rule, ErrorMessage } from '$lib/shared/types/FormDataTypes';
class Validator {
  email(value: string, message: string) {
    const emailLen = value ? value.trim().length : 0;
    if (emailLen < 1 || emailLen > EMAIL_MAX_LEN || !value?.includes('@')) {
      return {
        field: 'email',
        name: 'email',
        message: message
      };
    } else {
      return {
        field: 'email',
        name: 'email',
        message: ''
      };
    }
  }
  password(value: string, message: string) {
    const passwordLen = value ? value.trim().length : 0;
    if (passwordLen < 1) {
      return {
        field: 'password',
        name: 'password',
        message: message
      };
    } else {
      return {
        field: 'password',
        name: 'password',
        message: ''
      };
    }
  }
  latitude(value: string, message: string) {
    const latitude = parseFloat(value);
    return {
      field: 'latitude',
      name: 'latitude',
      message:
        !isNaN(latitude) && latitude >= 0 && latitude <= MAX_LATITUDE ? '' : message
    };
  }
  longitude(value: string, message: string) {
    const longitude = parseFloat(value);
    return {
      field: 'longitude',
      name: 'longitude',
      message:
        !isNaN(longitude) && longitude >= 0 && longitude <= MAX_LONGITUDE ? '' : message
    };
  }
  endpoint(value: string, message: string) {
    const ipPortPart = value.split(`/`)[0];
    const [ipPart, portPart] = ipPortPart.split(`:`);
    const portParsed = parseInt(portPart);
    const ipNumbers = ipPart.split('.');
    const isValid =
      !isNaN(portParsed) &&
      portParsed <= MAX_PORT &&
      portParsed > 0 &&
      ipNumbers.length === IP_LEN &&
      !ipNumbers.some(ipStrRaw => {
        const ipNumber = parseInt(ipStrRaw);
        return isNaN(ipNumber) || ipNumber > MAX_IP_NUMBER || ipNumber < 0;
      });
    return {
      field: 'endpoint',
      name: 'endpoint',
      message: isValid ? '' : message
    };
  }
}

const getValueForRule = (fields: Field[], ruleName: string): string => {
  const field = fields.find((field: Field) => field.name === ruleName);
  if (field) {
    return field?.value;
  } else {
    return 'valueNotFound';
  }
};

export function formValidation(fields: Field[], rules: Rule[]) {
  const validator = new Validator();
  let isValid = true;
  const messageArray: ErrorMessage[] = [];
  for (const rule of rules) {
    switch (rule.type) {
      case 'email':
        messageArray.push(
          validator.email(getValueForRule(fields, rule.fieldName), rule.message)
        );
        break;
      case 'password':
        messageArray.push(
          validator.password(getValueForRule(fields, rule.fieldName), rule.message)
        );
        break;
      case 'latitude':
        messageArray.push(
          validator.latitude(getValueForRule(fields, rule.fieldName), rule.message)
        );
        break;
      case 'longitude':
        messageArray.push(
          validator.longitude(getValueForRule(fields, rule.fieldName), rule.message)
        );
        break;
      case 'endpoint':
        messageArray.push(
          validator.endpoint(getValueForRule(fields, rule.fieldName), rule.message)
        );
        break;
      default:
        isValid = true;
    }
  }
  for (const item of messageArray) {
    if (item.message) {
      isValid = false;
    }
  }
  return [isValid, messageArray];
}
