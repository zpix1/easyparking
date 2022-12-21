<script lang="ts" context="module">
  export type AdminParkingFormType = 'add' | 'edit';
</script>

<script lang="ts">
  import Form from '$lib/shared/ui/Form.svelte';
  import { parkingCreationError } from '../entities/Parking';
  import type { AddParkingPayload } from '../entities/Parking';

  export let fields: {
    name: string;
    type: string;
    value: string;
  }[];
  export let submitCallback: (body: AddParkingPayload) => void;
  export let formType: AdminParkingFormType;

  const fieldsErrors = {
    title: '',
    address: '',
    latitude: '',
    longitude: '',
    // eslint-disable-next-line camelcase
    camera_endpoint: '',
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
      type: 'camera_endpoint',
      fieldName: 'camera_endpoint',
      message:
        'endpoint must be a string in format  "{camera ip}:{camera port}/#{possibly some path}"'
    },
  ];
</script>

<section>
  <Form
    className="compact"
    buttonLabel={formType === 'add' ? 'create parking' : 'edit parking'}
    totalError={parkingCreationError}
    bind:fields
    {fieldsErrors}
    {fieldsRules}
    {submitCallback}
  />
</section>
