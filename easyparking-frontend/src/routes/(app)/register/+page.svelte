<script lang="ts">
  import Link from '$lib/shared/ui/Link.svelte';
  import { register, registerError } from '$lib/entities/User';
  import Form from '$lib/shared/ui/Form.svelte';

  let buttonLabel = 'register';
  let totalError = registerError;
  const submitCallback = async (body: Record<string, string>) => {
    await register(body);
  };
  const fields = [
    { type: 'email', name: 'email', value: '' },
    { type: 'password', name: 'password', value: '' }
  ];
  const fieldsErrors = { email: '', password: '' };
  const fieldsRules = [
    {
      type: 'email',
      fieldName: 'email',
      message: 'email must be between 1 and 50 characters and contain @'
    },
    {
      type: 'password',
      fieldName: 'password',
      message: 'password must contain at least 1 character'
    }
  ];
</script>

<svelte:head>
  <title>Registration</title>
  <meta name="description" content="EasyParking registration" />
</svelte:head>

<section class="container">
  <h1>Welcome to Easy Parking, please register</h1>
  <Form
    className="large"
    {buttonLabel}
    {totalError}
    {fields}
    {fieldsErrors}
    {fieldsRules}
    {submitCallback}
  />
  <Link to="/login" text="Already registered?" classNames="default responsive" size="l" />
</section>

<style lang="scss">
  .container {
    width: 50%;
    padding: 0 10px 50px;
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
      padding: 0 0 50px;
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
