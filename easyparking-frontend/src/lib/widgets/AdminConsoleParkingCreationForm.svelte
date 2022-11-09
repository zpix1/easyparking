<script lang="ts">
  import Form from '$lib/shared/ui/Form.svelte';
  import { parkingCreationError } from '../entities/Parking';
  import { nop } from '$lib/shared/utils/utils';

  let totalError = parkingCreationError;
  const submitCallback = nop;
  const fields = [
    { name: 'name', type: 'text', value: '' },
    { name: 'address', type: 'text', value: '' },
    { name: 'latitude', type: 'latitude', value: '' },
    { name: 'longitude', type: 'longitude', value: '' },
    { name: 'endpoint', type: 'endpoint', value: '' }
  ];
  const fieldsErrors = {
    name: '',
    address: '',
    latitude: '',
    longitude: '',
    endpoint: ''
  };
  const fieldsRules = [
    {
      type: 'latitude',
      fieldName: 'latitude',
      message: 'latitude must be a float from 0 to 90'
    },
    {
      type: 'longitude',
      fieldName: 'longitude',
      message: 'longitude must be a float from 0 to 180'
    },
    {
      type: 'endpoint',
      fieldName: 'endpoint',
      message:
        'endpoint must be a string in format  "{camera ip}:{camera port}/#{possibly some path}"'
    }
  ];
</script>

<section>
  <Form
    className="compact"
    buttonLabel="create parking"
    {totalError}
    {fields}
    {fieldsErrors}
    {fieldsRules}
    {submitCallback}
  />
</section>
