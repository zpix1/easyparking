<script>
    // @ts-nocheck

    import Link from '$lib/shared/ui/Link.svelte';
    import { register, registerError } from '$lib/entities/User';
    import Form from '$lib/shared/ui/Form.svelte';

    let formType = 'lregister';
    let totalError = registerError;
    const submitCallback = (body) => {
        register(body);
    };
    const fields = [
        { type: 'email', name: 'EMAIL', value: '' },
        { type: 'password', name: 'PASSWORD', value: '' },
    ];
    const fieldsErrors = { email: '', password: '' };
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

<svelte:head>
    <title>Registration</title>
    <meta name="description" content="EasyParking registration" />
</svelte:head>

<section class="container">
    <h1>Welcome to Easy Parking, please register</h1>
    <Form
        {formType}
        {totalError}
        {fields}
        {fieldsErrors}
        {fieldsRules}
        {submitCallback}
    />
    <Link
        to="/login"
        text="Already registered?"
        classNames="default responsive"
        size="l"
    />
</section>

<style lang="scss">
    .container {
        width: 50%;
        padding: 0px 10px 50px;
        margin: 0 auto;
        display: flex;
        flex-direction: column;
        align-items: center;
    }
    h1 {
        text-align: center;
        font-size: 64px;
        line-height: 80px;
    }
    @media (max-width: 768px) {
        .container {
            width: 80%;
            padding: 0px 0px 50px;
        }
        h1 {
            font-size: 40px;
            line-height: 50px;
        }
    }
    @media (max-width: 426px) {
        h1 {
            font-size: 30px;
            line-height: 38px;
        }
    }
</style>
