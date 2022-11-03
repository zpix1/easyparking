<script>
    // @ts-nocheck
    import Button from '$lib/shared/ui/Button.svelte';
    import Loader from '$lib/shared/ui/Loader.svelte';
    import { userLoading } from '$lib/entities/User';
    import { formValidation } from '$lib/shared/utils/formValidator';

    export let formType = '';
    export let totalError = '';
    export let submitCallback = () => {};
    export let fields = [];
    export let fieldsErrors = {};
    export let fieldsRules = {};
    const submitHandler = () => {
        const body = {};
        for (const item of fields) {
            body[item.type] = item.value;
        }
        const [validForm, errorMessages] = formValidation(body, fieldsRules);
        if (validForm) {
            submitCallback(body);
        } else {
            for (const error of errorMessages) {
                fieldsErrors[error.field] = error.message;
            }
        }
    };
</script>

<form on:submit|preventDefault={submitHandler}>
    {#each fields as field (field.name)}
        <div class="form-field">
            <label for={field.type}>{field.name}</label>
            {#if field.type === 'password'}
                <input
                    type="password"
                    id={field.type}
                    bind:value={field.value}
                />
            {:else}
                <input type="text" id={field.type} bind:value={field.value} />
            {/if}

            <div class="error">{fieldsErrors[field.type]}</div>
        </div>
    {/each}
    <div class="error">{$totalError}</div>
    <Button type="submit">
        {#if $userLoading}
            <Loader />
        {:else}
            {formType}
        {/if}
    </Button>
</form>

<style lang="scss">
  form {
    min-width: 70%;
    margin: 0 auto;
    text-align: center;
    margin-bottom: 30px;
    .form-field {
      margin: 22px auto;
      text-align: left;
    }
    input {
      width: 100%;
      border-radius: 10px;
      height: 56px;
      margin-top: 20px;
      background: rgba(217, 217, 217, 0.7);
      font: var(--font-l);
      font-weight: 900;
      transition: all 0.5s;
      &:focus {
        outline: 3px solid var(--primary-color);
        filter: drop-shadow(2px 2px 5px #a09ef0)
          drop-shadow(-2px -2px 5px #831dd6);
      }
    }
    label {
      font: var(--font-m);
      font-weight: 600;
    }
    .error {
      text-align: center;
      font: var(--font-m);
      color: rgb(237, 110, 110);
    }
  }
  @media (max-width: 1091px) {
  }
  @media (max-width: 768px) {
    form {
      min-width: 100%;
      input {
        width: 100%;
        font: var(--font-m);
        font-weight: 900;
        transition: all 0.5s;
        &:focus {
          outline: 3px solid var(--primary-color);
          filter: drop-shadow(2px 2px 5px #a09ef0)
            drop-shadow(-2px -2px 5px #831dd6);
        }
      }
    }
  }
</style>
