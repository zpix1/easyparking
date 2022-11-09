export interface Field {
  type: string;
  name: string;
  value: string;
}

export interface Rule {
  type: string;
  fieldName: string;
  message: string;
}

export interface ErrorMessage {
  field: string;
  name: string;
  message: string;
}
