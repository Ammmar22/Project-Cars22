/* This file was generated by upb_generator from the input file:
 *
 *     envoy/extensions/filters/http/gcp_authn/v3/gcp_authn.proto
 *
 * Do not edit -- your changes will be discarded when the file is
 * regenerated. */

#include <stddef.h>
#include "upb/generated_code_support.h"
#include "envoy/extensions/filters/http/gcp_authn/v3/gcp_authn.upb_minitable.h"
#include "envoy/config/core/v3/base.upb_minitable.h"
#include "envoy/config/core/v3/http_uri.upb_minitable.h"
#include "google/protobuf/duration.upb_minitable.h"
#include "google/protobuf/wrappers.upb_minitable.h"
#include "envoy/annotations/deprecation.upb_minitable.h"
#include "udpa/annotations/status.upb_minitable.h"
#include "validate/validate.upb_minitable.h"

// Must be last.
#include "upb/port/def.inc"

static const upb_MiniTableSub envoy_extensions_filters_http_gcp_authn_v3_GcpAuthnFilterConfig_submsgs[5] = {
  {.UPB_PRIVATE(submsg) = &envoy__config__core__v3__HttpUri_msg_init},
  {.UPB_PRIVATE(submsg) = &envoy__config__core__v3__RetryPolicy_msg_init},
  {.UPB_PRIVATE(submsg) = &envoy__extensions__filters__http__gcp_0authn__v3__TokenCacheConfig_msg_init},
  {.UPB_PRIVATE(submsg) = &envoy__extensions__filters__http__gcp_0authn__v3__TokenHeader_msg_init},
  {.UPB_PRIVATE(submsg) = &google__protobuf__Duration_msg_init},
};

static const upb_MiniTableField envoy_extensions_filters_http_gcp_authn_v3_GcpAuthnFilterConfig__fields[6] = {
  {1, UPB_SIZE(12, 16), 64, 0, 11, (int)kUpb_FieldMode_Scalar | ((int)UPB_SIZE(kUpb_FieldRep_4Byte, kUpb_FieldRep_8Byte) << kUpb_FieldRep_Shift)},
  {2, UPB_SIZE(16, 24), 65, 1, 11, (int)kUpb_FieldMode_Scalar | ((int)UPB_SIZE(kUpb_FieldRep_4Byte, kUpb_FieldRep_8Byte) << kUpb_FieldRep_Shift)},
  {3, UPB_SIZE(20, 32), 66, 2, 11, (int)kUpb_FieldMode_Scalar | ((int)UPB_SIZE(kUpb_FieldRep_4Byte, kUpb_FieldRep_8Byte) << kUpb_FieldRep_Shift)},
  {4, UPB_SIZE(24, 40), 67, 3, 11, (int)kUpb_FieldMode_Scalar | ((int)UPB_SIZE(kUpb_FieldRep_4Byte, kUpb_FieldRep_8Byte) << kUpb_FieldRep_Shift)},
  {5, UPB_SIZE(32, 48), 0, kUpb_NoSub, 9, (int)kUpb_FieldMode_Scalar | ((int)kUpb_FieldRep_StringView << kUpb_FieldRep_Shift)},
  {6, UPB_SIZE(28, 64), 68, 4, 11, (int)kUpb_FieldMode_Scalar | ((int)UPB_SIZE(kUpb_FieldRep_4Byte, kUpb_FieldRep_8Byte) << kUpb_FieldRep_Shift)},
};

const upb_MiniTable envoy__extensions__filters__http__gcp_0authn__v3__GcpAuthnFilterConfig_msg_init = {
  &envoy_extensions_filters_http_gcp_authn_v3_GcpAuthnFilterConfig_submsgs[0],
  &envoy_extensions_filters_http_gcp_authn_v3_GcpAuthnFilterConfig__fields[0],
  UPB_SIZE(40, 72), 6, kUpb_ExtMode_NonExtendable, 6, UPB_FASTTABLE_MASK(56), 0,
#ifdef UPB_TRACING_ENABLED
  "envoy.extensions.filters.http.gcp_authn.v3.GcpAuthnFilterConfig",
#endif
  UPB_FASTTABLE_INIT({
    {0x0000000000000000, &_upb_FastDecoder_DecodeGeneric},
    {0x0000000000000000, &_upb_FastDecoder_DecodeGeneric},
    {0x0000000000000000, &_upb_FastDecoder_DecodeGeneric},
    {0x0000000000000000, &_upb_FastDecoder_DecodeGeneric},
    {0x0000000000000000, &_upb_FastDecoder_DecodeGeneric},
    {0x003000003f00002a, &upb_pss_1bt},
    {0x0000000000000000, &_upb_FastDecoder_DecodeGeneric},
    {0x0000000000000000, &_upb_FastDecoder_DecodeGeneric},
  })
};

static const upb_MiniTableField envoy_extensions_filters_http_gcp_authn_v3_Audience__fields[1] = {
  {1, 8, 0, kUpb_NoSub, 9, (int)kUpb_FieldMode_Scalar | ((int)kUpb_FieldRep_StringView << kUpb_FieldRep_Shift)},
};

const upb_MiniTable envoy__extensions__filters__http__gcp_0authn__v3__Audience_msg_init = {
  NULL,
  &envoy_extensions_filters_http_gcp_authn_v3_Audience__fields[0],
  UPB_SIZE(16, 24), 1, kUpb_ExtMode_NonExtendable, 1, UPB_FASTTABLE_MASK(8), 0,
#ifdef UPB_TRACING_ENABLED
  "envoy.extensions.filters.http.gcp_authn.v3.Audience",
#endif
  UPB_FASTTABLE_INIT({
    {0x0000000000000000, &_upb_FastDecoder_DecodeGeneric},
    {0x000800003f00000a, &upb_pss_1bt},
  })
};

static const upb_MiniTableSub envoy_extensions_filters_http_gcp_authn_v3_TokenCacheConfig_submsgs[1] = {
  {.UPB_PRIVATE(submsg) = &google__protobuf__UInt64Value_msg_init},
};

static const upb_MiniTableField envoy_extensions_filters_http_gcp_authn_v3_TokenCacheConfig__fields[1] = {
  {1, UPB_SIZE(12, 16), 64, 0, 11, (int)kUpb_FieldMode_Scalar | ((int)UPB_SIZE(kUpb_FieldRep_4Byte, kUpb_FieldRep_8Byte) << kUpb_FieldRep_Shift)},
};

const upb_MiniTable envoy__extensions__filters__http__gcp_0authn__v3__TokenCacheConfig_msg_init = {
  &envoy_extensions_filters_http_gcp_authn_v3_TokenCacheConfig_submsgs[0],
  &envoy_extensions_filters_http_gcp_authn_v3_TokenCacheConfig__fields[0],
  UPB_SIZE(16, 24), 1, kUpb_ExtMode_NonExtendable, 1, UPB_FASTTABLE_MASK(255), 0,
#ifdef UPB_TRACING_ENABLED
  "envoy.extensions.filters.http.gcp_authn.v3.TokenCacheConfig",
#endif
};

static const upb_MiniTableField envoy_extensions_filters_http_gcp_authn_v3_TokenHeader__fields[2] = {
  {1, 8, 0, kUpb_NoSub, 9, (int)kUpb_FieldMode_Scalar | ((int)kUpb_FieldRep_StringView << kUpb_FieldRep_Shift)},
  {2, UPB_SIZE(16, 24), 0, kUpb_NoSub, 9, (int)kUpb_FieldMode_Scalar | ((int)kUpb_FieldRep_StringView << kUpb_FieldRep_Shift)},
};

const upb_MiniTable envoy__extensions__filters__http__gcp_0authn__v3__TokenHeader_msg_init = {
  NULL,
  &envoy_extensions_filters_http_gcp_authn_v3_TokenHeader__fields[0],
  UPB_SIZE(24, 40), 2, kUpb_ExtMode_NonExtendable, 2, UPB_FASTTABLE_MASK(24), 0,
#ifdef UPB_TRACING_ENABLED
  "envoy.extensions.filters.http.gcp_authn.v3.TokenHeader",
#endif
  UPB_FASTTABLE_INIT({
    {0x0000000000000000, &_upb_FastDecoder_DecodeGeneric},
    {0x000800003f00000a, &upb_pss_1bt},
    {0x001800003f000012, &upb_pss_1bt},
    {0x0000000000000000, &_upb_FastDecoder_DecodeGeneric},
  })
};

static const upb_MiniTable *messages_layout[4] = {
  &envoy__extensions__filters__http__gcp_0authn__v3__GcpAuthnFilterConfig_msg_init,
  &envoy__extensions__filters__http__gcp_0authn__v3__Audience_msg_init,
  &envoy__extensions__filters__http__gcp_0authn__v3__TokenCacheConfig_msg_init,
  &envoy__extensions__filters__http__gcp_0authn__v3__TokenHeader_msg_init,
};

const upb_MiniTableFile envoy_extensions_filters_http_gcp_authn_v3_gcp_authn_proto_upb_file_layout = {
  messages_layout,
  NULL,
  NULL,
  4,
  0,
  0,
};

#include "upb/port/undef.inc"

