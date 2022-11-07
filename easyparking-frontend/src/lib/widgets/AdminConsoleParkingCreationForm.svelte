<script lang="ts">
    import Form from "$lib/shared/ui/Form.svelte";
    import {parkingCreationError} from "../entities/Parking";

    let buttonLabel = 'create parking';
    let totalError = parkingCreationError;
    const submitCallback = (body) => {

    };
    const fields = [
        { type: 'name', name: 'NAME', value: '' },
        { type: 'address', name: 'ADDRESS', value: '' },
        { type: 'latitude', name: 'LATITUDE', value: '' },
        { type: 'longitude', name: 'LONGITUDE', value: '' },
        { type: 'endpoint', name: 'ENDPOINT', value: '' },
    ];
    const fieldsErrors = { name: '', address: '', latitude: '', longitude: '', endpoint: '' };
    const fieldsRules = {
        email: {
            type: 'email',
            message: 'email must be between 1 and 50 characters and contain @',
        },
        password: {
            type: 'password',
            message: 'password must contain at least 1 character',
        },
    };
</script>

<section>
    <Form
        className="compact"
        {buttonLabel}
        {totalError}
        {fields}
        {fieldsErrors}
        {fieldsRules}
        {submitCallback}
    />
</section>