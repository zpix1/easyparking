<script lang="ts">
  import Button from '$lib/shared/ui/Button.svelte';
  import Loader from '$lib/shared/ui/Loader.svelte';
  import { userLoading } from '$lib/entities/User';
  import { formValidation } from '$lib/shared/utils/formValidator';
  import type { Field, Rule, ErrorMessage } from '$lib/shared/types/FormDataTypes';
  import type { Writable } from 'svelte/store';
  import { nop } from '$lib/shared/utils/utils.js';
  import type { ButtonSize } from '../types/ButtonTypes';
  export let className = '';
  export let submitBtnStyle = '';
  export let submitBtnSize: ButtonSize = 's';
  export let buttonLabel = '';
  export let totalError: Writable<string>;
  export let submitCallback: (body: Record<string, string>) => void;
  export let fields: Field[] = [];
  export let fieldsErrors: Record<string, string> = {};
  export let fieldsRules: Rule[] = [];

  let totalErrorMessage = ``;
  totalError.subscribe(error => {
    totalErrorMessage = error;
  });

  const submitHandler = () => {
    const body: Record<string, string> = {};
    for (const item of fields) {
      body[item.name] = item.value;
    }
    const [validForm, errorMessages] = formValidation(fields, fieldsRules);
    if (validForm) {
      submitCallback(body);
    } else {
      for (const error of errorMessages as ErrorMessage[]) {
        fieldsErrors[error.name] = error.message;
        console.log(fieldsErrors);
      }
    }
  };
</script>

<form class={className} on:submit|preventDefault={submitHandler}>
  {#each fields as field, i (field.name)}
    <div class="form-field">
      <label>{field.name}</label>
      {#if field.type === 'password'}
        <input type="password" bind:value={field.value} />
      {:else}
        <input type="text" bind:value={field.value} />
      {/if}

      <div class="error">{fieldsErrors[fields[i].name]}</div>
    </div>
  {/each}
  <div class="error">{totalErrorMessage}</div>
  <Button type="submit" size={submitBtnSize} classNames={submitBtnStyle} onClick={nop}>
    {#if $userLoading}
      <Loader />
    {:else}
      {buttonLabel}
    {/if}
  </Button>
</form>

<style lang="scss">
  form.large {
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
      transition: all 0.5s;
      &:focus {
        outline: 3px solid var(--primary-color);
        filter: drop-shadow(2px 2px 5px #a09ef0) drop-shadow(-2px -2px 5px #831dd6);
      }
    }
    label {
      font: var(--font-m);
      font-weight: 600;
      text-transform: uppercase;
    }
    .error {
      text-align: center;
      font: var(--font-m);
      color: rgb(237, 110, 110);
    }
  }

  form.compact {
    width: min(40rem, 70vw);
    display: table;
    flex-flow: column nowrap;
    .form-field {
      display: table-row;
      width: 100%;
      flex-flow: row nowrap;
      justify-content: space-between;
    }
    input {
      display: table-cell;
      width: 100%;
      margin-top: 1rem;
      border-radius: 10px;
      background: rgba(217, 217, 217, 0.7);
      font: var(--font-l);
      transition: all 0.5s;
      &:focus {
        outline: 3px solid var(--primary-color);
        filter: drop-shadow(2px 2px 5px #a09ef0) drop-shadow(-2px -2px 5px #831dd6);
      }
    }
    label {
      display: table-cell;
      font: var(--font-m);
      font-weight: 600;
      text-transform: uppercase;
    }
    .error {
      text-align: center;
      font: var(--font-m);
      color: rgb(237, 110, 110);
      margin-top: 5px;
      margin-bottom: 10px;
    }
    .total-error {
      text-align: left;
    }
  }
  @media (max-width: 768px) {
    form.large {
      min-width: 100%;
      input {
        width: 100%;
        font: var(--font-m);
        transition: all 0.5s;
        &:focus {
          outline: 3px solid var(--primary-color);
          filter: drop-shadow(2px 2px 5px #a09ef0) drop-shadow(-2px -2px 5px #831dd6);
        }
      }
    }

    form.compact {
      min-width: 100%;
      input {
        width: 100%;
        font: var(--font-m);
        transition: all 0.5s;
        &:focus {
          outline: 3px solid var(--primary-color);
          filter: drop-shadow(2px 2px 5px #a09ef0) drop-shadow(-2px -2px 5px #831dd6);
        }
      }
    }
  }
</style>
