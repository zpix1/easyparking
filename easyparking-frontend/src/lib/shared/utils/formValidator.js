// @ts-nocheck
class Validator {
    email(value, message){
        let emailLen = value ? value.trim().length : 0;
        if (emailLen < 1 || emailLen > 50 || !value.includes('@')) {
            return {
                field: 'email',
                message: message
            }
        } else {
            return {
                field: 'email',
                message: ''
            }
        }
    }
    password(value, message){
        let passwordLen = value ? value.trim().length : 0;
        if (passwordLen < 1) {
            return {
                field: 'password',
                message: message
            }
        } else {
            return {
                field: 'password',
                message: ''
            }
        }
    }
}

export function formValidation(fields, rules) {
    const validator = new Validator();
    let isValid = true;
    const messageArray = [];
    for(let rule of Object.keys(rules)){
        switch(rules[rule].type){
            case 'email':
                messageArray.push(validator.email(fields[rule], rules[rule].message));
                break;
            case 'password':
                messageArray.push(validator.password(fields[rule], rules[rule].message));
                break;
            default:
                isValid = true;    
        }
    }
    for(let item of messageArray){
        if(item.message) isValid = false;
    }
    return [isValid, messageArray];
}