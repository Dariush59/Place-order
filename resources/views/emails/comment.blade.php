@component('mail::message')
# Introduction

{{ $user->name }} your email successfully :

@component('mail::button', ['url' => 'http://google.com'])
login
@endcomponent

Thanks,<br>
{{ config('app.name') }}
@endcomponent
